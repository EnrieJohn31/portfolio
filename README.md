# Enrie John Edem - Portfolio

Recruiter-focused static portfolio for Linux infrastructure, systems automation, and DevOps-oriented roles. The site is intentionally framework-free so it remains fast, portable, and easy to deploy.

## Main files

- `index.html` - complete portfolio markup, styles, and interactions
- `Enrie_John_Edem_Resume.pdf` - text-native résumé linked from the site's download buttons
- `Enrie_John_Edem_Infrastructure_Systems_Engineer_Resume.pdf` - same résumé under the legacy filename, kept so older shared links keep resolving
- `Enrie_John_Edem_Infrastructure_Systems_Engineer_Resume.docx` - editable ATS-friendly résumé
- `og-image-v2.png` - recruiter-focused social sharing preview (1200x630, kept under ~150 KB)
- `certificates/` - course certificates and awards used by the credential viewer
- `vercel.json` - clean URLs and security headers
- `robots.txt`, `sitemap.xml`, and `404.html` - search and routing support

## Résumé source

The editable résumé source is `scripts/resume_source.html`. On Windows with Microsoft Word installed, rebuild the DOCX and PDF with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\build_resume.ps1
```

The generated artifacts are written to `output/docx/` and `output/pdf/`. The script also refreshes the portfolio download copies in the repository root, including the legacy PDF filename used by older links.

## Deploy to Vercel

This is a static project, so no build command or output directory is required.

```powershell
npm install -g vercel
vercel --prod
```

When moving to a custom domain, update the canonical URL, Open Graph URLs, JSON-LD URL, `robots.txt`, and `sitemap.xml` together.

## Content maintenance

Keep the portfolio and résumé aligned on job titles, dates, infrastructure scope, and outcome metrics. Describe projected cost avoidance as projected, and add exact measurement baselines only when they are safe to disclose and can be defended in an interview.

The provisioning metric appears in both `index.html` and `scripts/resume_source.html` and must be changed in both: `~4 hours` manual build-to-ready to `~17 minutes` automated (approximately 93%). It is stated with its basis on the page so it can be defended directly in an interview.

The migration outcome is deliberately stated qualitatively as eliminating dependency on commercial virtualization licensing, with no currency figure. A peso figure was considered and removed: VMware has licensed per physical core rather than per socket since the Broadcom acquisition, a Proxmox subscription is itself a per-socket cost that would have to be netted out, and operating-system and database licensing are unaffected by hypervisor choice. Do not reintroduce a cost-avoidance number without an actual vendor quote and a net-of-Proxmox calculation.
