# 我的开源博客（Ghost 二次开发实验）

基于 [Ghost](https://ghost.org/) 6.63.0 二次开发的个人博客系统，完成「实验01-开源个人博客系统二次开发」课程实验。

## 技术栈

| 组件 | 版本 / 说明 |
|---|---|
| Ghost | 6.63.0（development 模式，SQLite） |
| Node.js | v22.23.2 |
| npm | 10.9.8 |
| Ghost CLI | 1.32.5 |
| 数据库 | SQLite（`runtime/content/data/ghost-local.db`） |
| 自定义主题 | oss-blog-theme v1.0.0（fork 自 TryGhost/Source 1.7.4，MIT） |

## 目录结构

```
oss-blog/
├── runtime/                  # Ghost 运行时（不提交 Git）
│   └── content/themes/      # 已安装主题
├── theme/oss-blog-theme/    # 自定义主题源码（二次开发）
├── docs/                     # 文档、基线、演示数据、截图
│   └── screenshots/          # 实验汇报截图
├── scripts/                  # 辅助脚本（SMTP 测试服务器）
├── tests/                    # 测试记录
├── ppt-work/                 # 实验汇报 PPT
├── _agent_output/            # 脚本输出（不提交 Git）
├── README.md
├── NOTICE.md
└── .gitignore
```

## 快速启动

```bash
cd runtime
ghost start
```

启动后访问：
- 前台：http://localhost:2368/
- 管理端：http://localhost:2368/ghost

停止：`ghost stop`

> 评论功能依赖本地 SMTP 测试服务器：`node scripts/smtp-test-server.js`（监听 127.0.0.1:1025）

## 演示账号

| 角色 | 邮箱 | 密码 |
|---|---|---|
| 管理员（Owner） | admin@blog.local | Blog@2026admin |
| 会员 1 | member1@blog.local | （管理后台添加，Impersonate 登录） |
| 会员 2 | member2@blog.local | （管理后台添加，Impersonate 登录） |

## 功能清单

### MVP（必做）
- [x] 前台首页 / 文章列表 / 文章详情 / 标签页 / 作者页
- [x] 管理端：文章、标签、会员、评论、设置管理
- [x] 管理员账号（Owner）+ 普通会员账号
- [x] 文章发布（8 篇演示文章）、标签（3 个演示标签）
- [x] 评论功能（会员登录后可评论，comments_enabled = all）
- [x] 全站搜索（Ghost 原生搜索，导航栏搜索按钮，`data-ghost-search`）

### 完整版（拓展）
- [x] 自定义主题 oss-blog-theme（基于 Source 二次开发）
- [x] 8 篇文章 / 3 标签 / 2 会员
- [x] 错误状态处理（404 页、搜索无结果提示、相关文章无数据回退）
- [x] 备份与恢复（Ghost 导入/导出，Settings → Advanced → Import/Export）
- [x] 自主功能：**相关文章推荐**（按主标签匹配，无相关时回退最新文章）

## 自定义主题修改说明

主题源码：`theme/oss-blog-theme/`，上游：[TryGhost/Source](https://github.com/TryGhost/Source)（MIT）。

| 文件 | 修改内容 |
|---|---|
| `package.json` | name 改为 oss-blog-theme，version 1.0.0，描述标注 fork 来源 |
| `default.hbs` | 新增自定义 CSS（标签导航、全标签、阅读时长、相关文章区样式） |
| `partials/components/navigation.hbs` | 导航菜单后增加主要标签快捷入口（`{{#get "tags"}}`，limit 4） |
| `partials/post-card.hbs` | 文章卡片 meta 区增加阅读时长（`{{reading_time}}`） |
| `post.hbs` | 文章头部显示全部标签（不只主标签）；底部「Read more」改造为**按标签推荐相关文章**（自主功能） |

### 自主功能：相关文章推荐

- **用户价值**：读者读完一篇文章后，可看到同主题的延伸阅读，提高站内浏览深度。
- **数据来源**：Ghost Content API（主题内 `{{#get "posts"}}`，按 `tag:{{primary_tag.slug}}` 过滤）。
- **界面入口**：文章详情页底部。
- **失败状态**：无同标签文章时回退到最新文章推荐；均无时隐藏区块。
- **隐私影响**：无（纯服务端渲染，不收集用户行为）。
- **验收条件**：
  1. 有同标签文章时，详情页底部显示「相关文章」区，最多 4 篇；
  2. 推荐文章与当前文章共享至少一个标签，且不包含当前文章；
  3. 无同标签文章时显示「Read more」（最新文章）；
  4. 全站不足 2 篇文章时不显示推荐区。

## 备份与恢复

### 导出（备份）
管理端 → Settings → Advanced → **Import & Export** → Export → 下载 JSON 文件。

脱敏备份：`docs/backup/ghost-export-sanitized.json`（已移除 private key 和密码哈希）。

### 导入（恢复）
管理端 → Settings → Advanced → **Import & Export** → Import → 选择 JSON 文件 → 确认。

> 注意：Ghost 导入器对已存在内容会重复创建（slug 冲突时加 `-2` 后缀），建议导入前先清理或在新实例上恢复。

## 测试

测试记录见 `tests/acceptance.md`，共 45 项测试全部通过，覆盖：
- 功能测试（12 项：注册、登录、发文、评论、搜索、标签页）
- 权限测试（7 项：管理员 vs 会员 vs 访客）
- 界面测试（8 项：主题各页面渲染、响应式）
- 恢复测试（6 项：导出后重新导入验证）
- 自主功能测试（5 项：相关文章推荐）
- 其他测试（7 项）

## Git 过程证据

- 分支：`main`（基线）、`feature/custom-theme`（主题开发 + 自主功能）
- Pull Request：#1 `feat(theme): custom theme oss-blog-theme with related posts`（已合并）
- Code Review：PR Review 评论记录（"主题修改符合要求，相关文章推荐逻辑清晰，文档完整"）
- Merge Commit：`65add9f`
- Tag：`v1.0-lab`（实验交付版本，指向 65add9f）
- 仓库地址：https://github.com/783287393/blog

## 实验汇报

汇报 PPT：`ppt-work/实验01-开源个人博客系统二次开发.pptx`（14 页）
截图素材：`docs/screenshots/`（12 张）

## 许可证

本项目为课程实验，基于 Ghost 及 Source 主题二次开发。
- Ghost：MIT License
- Source 主题：MIT License（Copyright (c) Ghost Foundation）
- 本项目新增代码：MIT License

详见 [NOTICE.md](./NOTICE.md)。
