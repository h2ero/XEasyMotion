# AGENTS.md

## 项目概述

XEasyMotion 是一款 macOS 原生应用，通过键盘控制鼠标光标，灵感来自 [keynav](https://github.com/jordansissel/keynav)。核心思路：用全局热键唤起覆盖屏幕的网格（grid），用 `hjkl` 缩放/移动选中区域，再用回车等键在区域中心执行点击，从而实现纯键盘完成精确定位与点击。

- 平台：macOS（非 iOS）
- 语言：Swift 4.0
- 部署目标：macOS 10.11
- Bundle Identifier：`h2ero.XEasyMotion`
- 运行形态：状态栏后台应用（`LSBackgroundOnly = true`），无主窗口常驻

## 技术栈

- **Cocoa / AppKit**：UI、窗口、状态栏、Storyboard（`Main.storyboard`）。
- **Carbon（`Carbon.framework`）**：全局热键与键码映射，是本项目最关键、也最易踩坑的依赖。`HotKeys.swift` 封装热键注册，`Constents.swift` 用 `kVK_ANSI_*` 常量做键码映射。
- **Storyboard + 手写控制器混合**：入口 storyboard 为 `Main`，窗口控制器（`MainWindowController`、`AboutWindowController`、`SettingWindowController`）通过 `NSStoryboard` 实例化。

## 架构与关键文件

```
XEasyMotion/
├── AppDelegate.swift          # 入口（@NSApplicationMain），状态栏菜单、About/Setting
├── MainWindow.swift / MainWindowController.swift  # 全屏覆盖网格窗口
├── GradView.swift             # 网格视图 + hit-char 提示绘制（类名拼写为 GradView，历史遗留）
├── HotKeys.swift              # Carbon 全局热键注册/注销（核心）
├── Constents.swift            # 常量：模式、键码映射、hitChars（类名拼写为 Constents，历史遗留）
├── Config.swift               # 读取 ~/.xeasymotionrc dotfile
├── Util.swift / Log.swift     # 工具与日志
├── Mode/
│   ├── Mode.swift             # 模式基类，注册各类键绑定（点击/移动/悬停/撤销…）
│   ├── SimpleMode.swift       # 简单模式
│   └── NineBlockMode.swift    # 九宫格模式（默认）
├── AboutWindowController.swift / AboutViewControoler.swift
├── SettingWindowController.swift / SettingViewController.swift
├── Base.lproj/Main.storyboard
├── Info.plist
└── Assets.xcassets            # AppIcon、statusBarIcon
```

**核心数据流**：`AppDelegate` 启动 → 状态栏就绪 → 全局热键 `Cmd+I`（`Mode.addActiveKeyBind`）唤起 → 全屏网格窗口 `maxWindow` → 注册一组操作键绑定 → 点击/移动后撤销键绑定、隐藏网格。

`Mode` 基类维护 `positionHistory`、`clickHistory`，支持撤销（`u`）、回到上次点击位置（`o`）、重复上次点击（`.`）。

## 设置命令

项目为 Xcode 工程（`.xcodeproj`），无包管理器依赖（历史用过 Carthage，现 `Carthage/*` 与 `Cartfile.resolved` 已 gitignore）。建议用 `xcodebuild` 命令行构建/测试：

```bash
# 构建（Debug，默认 scheme XEasyMotion）
xcodebuild -project XEasyMotion.xcodeproj -scheme XEasyMotion -configuration Debug build

# 构建 Release
xcodebuild -project XEasyMotion.xcodeproj -scheme XEasyMotion -configuration Release build

# 运行单元测试
xcodebuild -project XEasyMotion.xcodeproj -scheme XEasyMotion test

# 在 Xcode 中打开
open XEasyMotion.xcodeproj
```

> 按用户偏好：macOS/iOS 类项目不强制每次构建验证，但改动涉及热键或窗口逻辑时应本地构建确认无误。

## macOS 权限要求（重要）

应用依赖 **Accessibility（辅助功能）权限** 才能模拟鼠标事件与捕获全局键盘。每次重新构建运行后系统会撤销该权限，必须重新授予：

1. 打开「系统设置 → 隐私与安全性 → 辅助功能」。
2. 添加并勾选 `XEasyMotion`；若已存在，取消勾选再重新勾选。
3. 保持该设置面板解锁，便于反复操作。

若热键无响应、点击无效果，**首先排查 Accessibility 权限**，而非代码逻辑。

## 代码风格

- 类名 PascalCase，方法/属性 camelCase。
- 文件头沿用 Xcode 模板注释（作者/日期/copyright），新增文件保持一致。
- **代码内的文案与注释用英文**（遵循项目惯例与全局约定）。
- 常量与键码映射集中在 `Constents.swift`，热键注册集中在 `HotKeys.swift`，新增热键/键位时先到这两处查找。
- 注意历史遗留拼写：`Constents`（应为 Constants）、`GradView`（应为 GridView）、`ConolePlay`、`AboutViewControoler`。**新增代码不要沿用这些拼写错误**，但也不要为重命名而全局改动（会牵连 storyboard / pbxproj 引用）。
- Swift 版本为 4.0，慎用新版语法糖（`@propertyWrapper`、`Result` 默认值、并发 API 等在旧部署目标下不可用）。

## 测试说明

- 单元测试 target：`XEasyMotioinTests/XEasyMotionTests.swift`（注意目录名拼写为 `XEasyMotioinTests`）。
- UI 测试 target：`XEasyMotionUITests/XEasyMotionUITests.swift`。
- 运行：`xcodebuild -project XEasyMotion.xcodeproj -scheme XEasyMotion test`。
- 项目另有两个 Playground（`ConolePlay.playground`、`MyPlayground.playground`），用于原型试验，**被 `.gitignore` 忽略**，不参与构建。

## 提交规范

- 提交信息用**中文**（遵循全局约定）。
- 沿用仓库现有风格：简短描述即可，无需强制 conventional-commits。
- 提交前自检：
  - 是否误提交 `.DS_Store`、`*.sw*`、`tags`、`xcuserdata/`、`Carthage/`（已在 `.gitignore`）。
  - 是否改动 `.playground`（已被忽略，不应入库）。

## 常见任务

- **新增一个操作键**：在 `Constents.swift` 添加键码 → 在 `Mode`（或子类）的对应 `addXxxKeyBind` 中用 `HotKeys.register(...)` 注册，并在 `addActiveKeyBind` 的唤起闭包内调用。
- **新增一种模式**：继承 `Mode`，实现 `addHitKeyBind` / `addClickBinds` / `addMoveKeyBind` 等，并在 `Config.getEnableMode()` 切换。
- **改默认模式**：修改 `Constents.mode`（当前默认 `nineBlockMode`）。
- **调整用户配置**：编辑 `Config.swift`，配置文件位于 `~/.xeasymotionrc`（dotfile）。

## 安全与发布

- 发布产物见 GitHub Releases：https://github.com/h2ero/XEasyMotion/releases
- `Info.plist` 当前未声明沙盒（非 sandboxed app），这是模拟全局输入所必需的；改架构时注意沙盒会限制 Carbon 全局热键与鼠标事件注入。
