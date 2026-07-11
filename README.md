# Enrie John Edem — Portfolio

Static HTML portfolio prepared for Vercel.

## Files

- `index.html` — portfolio website (single file: markup, CSS, JS)
- `Enrie_John_Edem_Resume.pdf` — downloadable resume (the HTML points to this exact filename)
- `certificates/` — kebab-case certificate PDFs/JPGs opened by the in-page viewer
- `vercel.json` — clean URLs and security headers (incl. Content-Security-Policy)
- `robots.txt` / `sitemap.xml` — crawler directives
- `404.html` — custom not-found page

## Manual follow-ups (owner actions)

1. **Custom domain** — buy one (e.g. `enriejohn.dev`) and add it in Vercel. Then update the URL in: `<link rel="canonical">`, all `og:`/`twitter:` meta URLs, the JSON-LD `url`/`image`, `robots.txt`, and `sitemap.xml`.
2. **Vercel Web Analytics** — the snippet is already in `index.html`; enable it in Vercel: Project → Analytics → Enable. Until enabled, the script 404s harmlessly.
3. **Publish a sanitized automation repo** on GitHub (Ansible role + Terraform `bpg/proxmox` example with dummy variables), then link it from the "Proxmox Provisioning Automation" project card. The site now links your GitHub profile — an empty profile undercuts it.
4. **Fonts (optional next step)** — currently trimmed and loaded async from Google Fonts. Self-hosting subsetted woff2 files would remove the third-party request chain entirely.

## Deploy with Vercel CLI

```bash
npm install -g vercel
cd enrie-portfolio-vercel
vercel --prod
```

Follow the CLI prompts. For this static project, no build command is required.

## Deploy through Git

1. Create a repository and add these files at the repository root.
2. Import the repository in Vercel.
3. Set Framework Preset to `Other`.
4. Leave Build Command empty.
5. Leave Output Directory empty (repository root).
6. Deploy.

## Before publishing

Verify every metric and technology claim in `index.html`, especially the host/container/VM counts, provisioning-time reduction, staff supported, Terraform usage, and certifications in progress.

## Impact metric notes

- `₱8M+ license cost avoided` is a public-safe **projected VMware license cost avoidance** claim from choosing Proxmox VE. Do not describe it as annual savings or audited realized savings unless finance-approved evidence exists.
- The Linux/LXC positioning should stay workload-aware: Linux-first web app hosting and LXC containers are preferred for lightweight, cost-effective workloads, while the 12 managed VMs remain valid when an application needs stronger isolation, Windows Server, OS-specific dependencies, or dedicated resource boundaries.
- Windows Server usage does not weaken the Linux/Proxmox story. Frame it as pragmatic workload placement for systems such as file services, payroll, and Business Central that require or strongly fit Windows.
