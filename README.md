# 11HTML

GitHub Pages 站点仓库，本地目录 `D:\11HTML`。

纯静态、无构建步骤，沿用 `D:\HTML` 的做法：页面就是一个自包含的 HTML 文件，改完 push 到 `main` 即发布。

## 目录结构

```
11HTML/
├─ index.html     首页（页面导航，PAGES 数组在文件底部）
├─ 404.html       自定义 404
├─ .nojekyll      关闭 Jekyll 处理（下划线开头的文件才不会被忽略）
├─ .gitignore
└─ preview.ps1    本地起 http 服务预览
```

新页面直接放根目录或子目录，例如 `demo/index.html`，然后在 `index.html` 的 `PAGES` 里加一行：

```js
{ name: "示例页面", href: "demo/index.html", desc: "一句话说明" },
```

## 本地预览

```powershell
cd D:\11HTML
.\preview.ps1          # 默认 8000 端口，自动开浏览器
.\preview.ps1 -Port 8080
```

等价于 `python -m http.server 8000`。直接双击 `index.html` 也能看，但涉及 `fetch` 或相对路径时，用 http 服务更接近线上。

## 发布到 GitHub Pages

首次（仓库还没建）：

```powershell
# 1) GitHub 上新建仓库 11HTML（Public，不要勾 Initialize with README）
# 2) 关联并推送
git remote add origin git@github.com:Link-DMW/11HTML.git
git push -u origin main
# 3) 网页端：Settings → Pages → Source 选 Deploy from a branch → main / (root) → Save
```

一两分钟后访问：<https://link-dmw.github.io/11HTML/>

日常更新：

```powershell
git add -A
git commit -m "更新 xxx 页面"
git push
```

## 约定与坑

- **资源一律用相对路径**。站点根是 `/11HTML/` 而不是 `/`，写 `/chart.umd.min.js` 会 404，要写 `chart.umd.min.js`。
- `404.html` 里的返回链接写死了 `/11HTML/`，仓库改名要同步改。
- `.nojekyll` 必须有，否则 Jekyll 会吞掉 `_` 开头的东西。
- Pages 跑在 Linux 上，**大小写敏感**：`Index.html` 不等于 `index.html`。
- 页面里不要用 `fetch('/history')` 这种根路径 —— 在 Pages 上会打到 `https://link-dmw.github.io/` 根，而不是本站。用完整的后端 URL。
- 单文件别超过 100 MB（GitHub 单文件硬限制），仓库建议控制在 1 GB 内。

## 和 D:\HTML 的关系

`D:\HTML` 是之前的「店铺指标看板」，远程仓库 `Link-DMW/Data`，数据来自腾讯云函数后端。
`11HTML` 是独立站点，不继承那边的 git 历史；需要图表时把 `D:\HTML\chart.umd.min.js` 复制过来即可。
