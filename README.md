# Enrie John Edem - Portfolio

Recruiter-focused static portfolio for Linux infrastructure, systems automation, and DevOps-oriented roles. The site is intentionally framework-free so it remains fast, portable, and easy to deploy.

## Main files

- `index.html` - complete portfolio markup, styles, and interactions
- `Enrie_John_Edem_Infrastructure_Systems_Engineer_Resume.pdf` - text-native résumé for direct download
- `Enrie_John_Edem_Infrastructure_Systems_Engineer_Resume.docx` - editable ATS-friendly résumé
- `og-image-v2.png` - recruiter-focused social sharing preview
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
