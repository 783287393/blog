# NOTICE

本项目为「实验01-开源个人博客系统二次开发」课程实验作品，基于以下开源软件二次开发。

## 第三方软件与许可证

### 1. Ghost
- 来源：https://ghost.org/ / https://github.com/TryGhost/Ghost
- 版本：6.63.0
- 许可证：MIT License
- 用途：博客系统运行时（CMS 核心、Content API、管理端、会员、评论、搜索）

### 2. Source 主题（Ghost 官方主题）
- 来源：https://github.com/TryGhost/Source
- 原始版本：1.7.4
- 本项目衍生版本：oss-blog-theme 1.0.0
- 许可证：MIT License
- Copyright (c) Ghost Foundation
- 用途：自定义主题的基础模板，已进行二次开发（导航、文章卡片、详情页元数据、相关文章推荐）

### 3. Node.js 运行时
- 来源：https://nodejs.org/
- 版本：v22.23.2
- 许可证：Node.js License（MIT 及其他开源许可证组合）

### 4. Ghost CLI
- 来源：https://github.com/TryGhost/Ghost-CLI
- 版本：1.32.5
- 许可证：MIT License

### 5. SQLite
- 来源：https://www.sqlite.org/
- 许可证：Public Domain（SQLite 代码属于公有领域）
- 用途：本地开发数据库

## 二次开发声明

本项目在 Source 主题基础上进行了以下修改：
- `package.json`：主题名称、版本、描述更新
- `default.hbs`：新增自定义样式
- `partials/components/navigation.hbs`：增加标签快捷导航
- `partials/post-card.hbs`：增加阅读时长显示
- `post.hbs`：头部显示全部标签；底部增加「相关文章推荐」自主功能

所有修改均保留原始 MIT 许可证。

## 本项目许可证

本项目新增代码及文档采用 MIT License。
