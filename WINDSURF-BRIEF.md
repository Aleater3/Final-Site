# Be Extraordinary — Windsurf Execution Brief
# Paste this ENTIRE file into Windsurf as your first prompt.
# Do not skip steps. Execute in order.

---

## PROJECT IDENTITY
- Site name: Be Extraordinary
- Domain: be-extraordinary.site
- Owner: Antwane Leater — Execution Strategist, Moreno Valley CA
- Tagline: Stop stalling. Start executing.
- Mantra: Excel. Exceed. Inspire.
- Primary CTA URL: https://silver-stream-pay.lovable.app
- CTA label: Book Your Forensic Audit

---

## STACK (use exactly this)
- Pure HTML + CSS + vanilla JS (no frameworks, no build tools)
- Single page: index.html
- Quiz page: quiz.html (already built — DO NOT rewrite it)
- Assets folder: /assets/
- Fonts: Instrument Serif (display) + Inter (body) via Google Fonts
- Deploy target: Netlify drop (static, no server required)

---

## FILE STRUCTURE TO CREATE
be-extraordinary-site/
├── index.html
├── quiz.html          ← copy from be-extraordinary-execution-blocker-quiz-1-1.html
└── assets/
    ├── headshot.jpg         ← 1000025667.jpeg renamed
    ├── logo-black.jpg       ← 1000025664.jpeg renamed
    ├── wordmark.jpg         ← 1000025662.jpeg renamed
    ├── logo-white.jpg       ← 1000025665.jpeg renamed
    ├── testimonial-marcus.jpg   ← 37bd9d8e..._5491.jpg renamed
    ├── testimonial-brittany.jpg ← 1000021775.jpg renamed
    └── testimonial-carlos.jpg  ← 37bd9d8e..._5489.jpg renamed

---

## DESIGN REFERENCE
Clone layout + feel of: https://jopecuro.com
Key traits to replicate:
- Bold editorial stacked display headings (serif italic accents)
- Clean white background, black text, no color accent
- Generous whitespace between sections
- Thin 1px borders on cards
- Minimal nav: logo left, links center, CTA button right
- Scroll-driven fade-in reveals (CSS only, no JS libraries)
- Light/dark mode toggle (CSS data-theme attribute)
- Fully responsive: mobile-first, single column on <768px

---

## COLOR TOKENS
[data-theme="light"]:
  --bg: #fafaf8
  --surface: #f4f3ef
  --border: rgba(0,0,0,0.08)
  --text: #111110
  --text-muted: #6b6a66
  --text-faint: #b5b4af
  --accent: #111110
  --inverse-text: #fafaf8

[data-theme="dark"]:
  --bg: #0f0f0e
  --surface: #1a1a18
  --border: rgba(255,255,255,0.08)
  --text: #e8e7e3
  --text-muted: #787671
  --text-faint: #4a4946
  --accent: #e8e7e3
  --inverse-text: #0f0f0e

---

## TYPOGRAPHY SCALE
--text-hero: clamp(3.5rem, 1rem + 8vw, 9rem)   → hero h1 only
--text-3xl:  clamp(2.5rem, 1rem + 4vw, 5rem)   → section headings
--text-2xl:  clamp(2rem, 1.2rem + 2.5vw, 3.5rem)
--text-xl:   clamp(1.5rem, 1.2rem + 1.25vw, 2.25rem)
--text-lg:   clamp(1.125rem, 1rem + 0.75vw, 1.5rem)
--text-base: clamp(1rem, 0.95rem + 0.25vw, 1.125rem)  → body copy
--text-sm:   clamp(0.875rem, 0.8rem + 0.35vw, 1rem)   → nav, buttons
--text-xs:   clamp(0.75rem, 0.7rem + 0.25vw, 0.875rem) → labels, captions

---

## PAGE SECTIONS (in order)

### 1. NAV (fixed, 80px tall)
- Left: logo-black.jpg (36px tall). Switches to logo-white.jpg in dark mode.
- Center: About | What I Do | Results | Free Quiz (anchor links)
- Right: moon/sun theme toggle icon + "Book Audit →" pill button
- Mobile: hamburger menu, links stack vertically

### 2. HERO
- Eyebrow text (uppercase, letter-spaced): "Moreno Valley, CA — Execution Strategist"
- H1 (hero scale, Instrument Serif): Stop / [italic]stalling.[/italic] / Start / executing.
- Below a 1px divider: 2-col grid
  - Left: body text describing Antwane (see COPY below)
  - Right: "Book Your Forensic Audit →" primary pill button + "Take the Quiz ↓" ghost link

### 3. MARQUEE (CSS animation, no JS)
- Looping ticker: Excel. Exceed. Inspire ◆ Execution Over Excuses ◆ 90-Day Architecture ◆ Results Not Rhetoric ◆ Be Extraordinary ◆ Forensic Audit ◆ (repeat)
- Pause on hover
- Instrument Serif italic, --text-faint color

### 4. ABOUT (2-col grid)
- Left: headshot.jpg (aspect-ratio 3/4, object-fit cover, slight grayscale)
  - Badge overlay bottom-left: "Antwane Leater"
- Right: heading + 2 body paragraphs + skill tags + CTA button
- Heading (Instrument Serif 2xl): "I excavate / what's [italic]actually[/italic] / stopping you."

### 5. SERVICES (3-col card grid)
- Heading: "I work to give clients [italic]extraordinary[/italic] results."
- Card 01 — Forensic Audit
- Card 02 — 90-Day Architecture
- Card 03 — Execution Coaching
- Each card: number label, serif heading, body, "CTA →" link
- Cards lift on hover (translateY -2px + surface background)

### 6. TESTIMONIALS (3-col grid)
- Intro row: section title left + "Get Your Results →" ghost link right
- 3 cards with opening quote mark, quote text, divider, avatar + name/role
  - Marcus T. / Entrepreneur & Fitness Coach / testimonial-marcus.jpg
  - Brittany R. / Brand Strategist & Creative Director / testimonial-brittany.jpg
  - Carlos M. / Real Estate Investor / testimonial-carlos.jpg

### 7. QUIZ CTA (2-col surface card)
- Left: label, heading "Find out what's [italic]really[/italic] killing your momentum.", description, button → quiz.html
- Right (border-left): 4 stats stacked
  - 10 / Fast Questions
  - 4 / Blocker Profiles
  - 72hr / Action Plan
  - Free / No Email Required

### 8. BIG CTA (full-width, centered)
- Eyebrow: "Ready to Execute?"
- Hero-scale heading: Be / [italic]Extra- / ordinary.[/italic]
- 2 buttons: "Book Your Forensic Audit →" (primary) + "Take the Free Quiz first ↗" (ghost)

### 9. FOOTER
- Left: logo + copyright "© 2026 Be Extraordinary. Antwane Leater."
- Center: About | Services | Results | Free Quiz | Book Audit
- Right: italic mantra "Excel. Exceed. Inspire."

---

## COPY

### Hero body:
"I'm Antwane Leater — execution strategist for driven entrepreneurs who are idea-rich and action-poor. I don't motivate you. I dismantle what's blocking you and build a system that forces results."

### About paragraph 1:
"Most coaching gives you inspiration. I give you a diagnosis. I use a Forensic Audit process to find the exact gap between where you are and where you're trying to go — then build a 90-day execution architecture around it."

### About paragraph 2:
"I work with entrepreneurs who already know what they want. They just can't seem to close the distance. That's where I come in. No fluff. No cheerleading. Just the system that gets you there."

### About tags:
90-Day Architecture | Forensic Audit | Accountability Loops | Mindset Reprogramming | Execution Systems

### Service 01 — Forensic Audit:
"A deep diagnostic session to identify exactly what's blocking your momentum — mindset, systems, or strategy. You leave with clarity and a precise roadmap forward."

### Service 02 — 90-Day Architecture:
"A custom execution system built around your goals: daily accountability loops, weekly targets, and the exact sequence of actions to hit your breakthrough in 90 days."

### Service 03 — Execution Coaching:
"Ongoing 1-on-1 coaching with daily 9am/9pm accountability touchpoints. High-frequency, high-stakes — keeps you executing, not just planning."

### Testimonial — Marcus T.:
"I had the idea for my coaching business for 3 years but kept making excuses. One conversation with Antwane exposed exactly why I was self-sabotaging. Within 60 days I launched, landed my first 5 clients, and hit $4,200 in revenue. He doesn't let you hide behind your potential."

### Testimonial — Brittany R.:
"Antwane helped me stop undercharging and start owning my worth. I raised my rates by 40%, restructured my offer suite, and signed my biggest retainer client — $6,500/month — all within 90 days. What he creates isn't just motivation. It's a system that actually works."

### Testimonial — Carlos M.:
"I was stuck analyzing deals and never pulling the trigger. Antwane shifted my mindset from fear-based to execution-based in the first week. I closed my first investment property two months later. The accountability structure he built kept me locked in when doubt crept back."

### Quiz description:
"10 questions. 4 blocker profiles. One 72-hour action plan built for your exact pattern. Overthinking, scattered focus, self-doubt, or unsustainable intensity — you'll know in under 3 minutes."

---

## ANIMATIONS (CSS only — no AOS, no GSAP, no ScrollReveal)

### Scroll fade-in:
@supports (animation-timeline: scroll()) {
  .fade-in {
    opacity: 0;
    animation: fadeReveal linear both;
    animation-timeline: view();
    animation-range: entry 0% entry 60%;
  }
}
@keyframes fadeReveal { to { opacity: 1; } }

Apply .fade-in to: about, services, testimonials, quiz, big-cta sections.
NEVER use translateY on scroll-triggered elements (causes layout shift).

### Marquee:
@keyframes marquee { to { transform: translateX(-50%); } }
.marquee-track { animation: marquee 28s linear infinite; }
.marquee-section:hover .marquee-track { animation-play-state: paused; }

### Hover states:
- Service cards: transform: translateY(-2px) + background: var(--surface)
- All CTA buttons: opacity: 0.8 + transform: translateY(-1px)
- Service link arrow gap: gap widens on hover

---

## JS (vanilla, ~40 lines max)
1. Theme toggle: toggles data-theme="dark"/"light" on <html>, swaps logo src
2. Mobile nav: toggles .open class on nav-links, updates aria-expanded

---

## QUALITY CHECKLIST (verify before done)
- [ ] One <h1> per page
- [ ] All <img> tags have alt, width, height, loading="lazy" (hero: loading="eager")
- [ ] No inline styles except one-off margin/alignment tweaks
- [ ] All external links: target="_blank" rel="noopener noreferrer"
- [ ] Passes lighthouse accessibility: aria-label on icon buttons, role="navigation", skip link
- [ ] Mobile tested: nav collapses, all grids go single-column, no horizontal overflow
- [ ] Dark mode: all colors switch, logo swaps, no hardcoded hex colors outside :root

---

## EXECUTION ORDER FOR WINDSURF
1. Create folder structure
2. Rename and place all asset images
3. Copy quiz.html from the provided file
4. Write index.html with all sections above
5. Verify dark mode toggle works
6. Verify mobile layout
7. Open in browser and confirm all sections render
8. Final check: all CTAs link to https://silver-stream-pay.lovable.app

---
END OF BRIEF
