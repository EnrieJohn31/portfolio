# Enrie John Edem — Portfolio

Static HTML portfolio prepared for Vercel.

## Files

- `index.html` — portfolio website
- `Enrie_John_Edem.pdf` — downloadable resume (the HTML already points to this exact filename)
- `vercel.json` — clean URLs and basic security headers
- `404.html` — custom not-found page

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
