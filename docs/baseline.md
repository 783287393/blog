# 实验基线记录（docs/baseline.md）

> 本文件记录实验 01「开源个人博客系统二次开发」的基线环境与上游版本，用于区分「上游能力」与「本人二次开发」。

## 1. 项目选型与固定版本

| 项目 | 选择 | 固定版本 | 许可证 | 说明 |
|---|---|---|---|---|
| 博客平台 | TryGhost/Ghost | **6.63.0** | MIT | 直接可运行的内容与会员博客平台；本实验基线 |
| 博客业务规范 | realworld-apps/realworld | 参考仓库（未锁定单一 Commit） | 逐项核对 | 作为业务域与测试思路参考，不直接运行 |
| Ghost CLI | ghost-cli | **1.32.5** | MIT | 本地安装与进程管理 |

- 选型理由：Ghost 具备成熟编辑器、标签、会员、评论与主题机制，能把课堂时间集中在阅读、配置与扩展上（对应实验文档第 4 节推荐路线）。
- 固定方式：Ghost 通过 `runtime/versions/6.63.0` 固定；npm 依赖锁文件随主题仓库提交。

## 2. 本地环境版本（已核验，2026-09-10）

| 工具 | 版本 | 要求 | 结论 |
|---|---|---|---|
| 操作系统 | Windows（LAPTOP-91C558BF） | Windows 11 当前受支持版本 | ✅ |
| Git | 2.55.0.windows.5 | 2.40+ | ✅ |
| Node.js | v22.23.2 | 22 LTS | ✅ |
| npm | 10.9.8 | 随 Node | ✅ |
| Ghost CLI | 1.32.5 | 与 Ghost 6.63.0 兼容 | ✅ |

## 3. 运行目录与配置

- 运行目录：`D:\oss-blog\runtime`（Ghost 运行目录必须为空，故放在仓库 `runtime/` 子目录）
- 前台地址：http://localhost:2368/
- 管理端地址：http://localhost:2368/ghost
- 端口：2368（配置于 `runtime/config.development.json`）
- 数据库：SQLite，文件 `runtime/content/data/ghost-local.db`
- 邮件：Direct 传输（本地开发模式，不发真实邮件）
- 进程管理：Ghost CLI local 模式（`runtime/.ghostpid` 记录进程 PID）

## 4. 安装时间线

| 时间（UTC+8） | 事件 |
|---|---|
| 2026-09-09 前后 | 创建 GitHub 仓库 `783287393/blog`，初始化本地仓库骨架（`docs/ theme/ tests/ runtime/` + `.gitignore`），初始提交 `bf77190` |
| 2026-09-10 00:50 | `ghost install local` 完成，首次启动 Ghost 6.63.0，数据库自动建表完成（日志：`Database is in a ready state`） |
| 2026-09-10 00:52 | 访问 `/ghost` 管理端页面（尚未完成管理员初始化） |

## 5. 数据与安全边界

- 以下内容**不得**提交到 Git（已在 `.gitignore` 声明，后续按需补充）：
  - `runtime/content/data/`（SQLite 数据库）
  - `runtime/content/logs/`（运行日志）
  - `runtime/content/keys/`、`uploads/`、`files/`、`images/`（上传与密钥）
  - `node_modules/`、`*.env`、`*.log`
- 管理员/会员密码不提交；对外只提供演示账号（见 README）。
- 数据备份与恢复通过 Ghost 管理端「Labs → 导出」完成，恢复方式见 README。

## 6. 基线功能清单（步骤 2 记录占位）

> 本清单在「管理员初始化 + 基线功能验证」完成后更新，作为后续每个 PR 相对基线的对照。

- [ ] 前台可访问
- [ ] `/ghost` 管理端可访问（管理员已初始化）
- [ ] 发布一篇文章（含标签）
- [ ] 创建普通会员账号并登录
- [ ] 启用评论，会员可评论
- [ ] 关键词搜索命中
- [ ] `ghost stop` / `ghost start` 重启后数据仍在
