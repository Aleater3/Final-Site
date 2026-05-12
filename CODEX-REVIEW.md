# Website Overview for Codex Review

## Project Information
- **Name**: Be Extraordinary Coaching Website
- **Author**: Antwane Leater
- **Type**: Static HTML/CSS/JavaScript site
- **Deployment**: Vercel
- **Live URL**: https://be-extraordinary.site

## File Structure
```
/
├── be-extraordinary.html    # Main landing page (served at /)
├── quiz.html               # Execution Blocker Diagnostic (served at /quiz)
├── assets/                 # Static assets directory
├── package.json            # Project metadata
├── vercel.json            # Vercel configuration
└── .env.local             # Environment variables (not deployed)
```

## URL Routing (vercel.json)
- `/` → `be-extraordinary.html` (main landing page)
- `/quiz` → `quiz.html` (diagnostic quiz)
- `/assets/*` → Static assets with caching
- `/(.*)` → Direct file access

## Technical Stack
- **Frontend**: Vanilla HTML5, CSS3, JavaScript
- **Quiz Page**: React 18 (via CDN), Babel standalone
- **Styling**: CSS custom properties, responsive design
- **Fonts**: Google Fonts (Instrument Serif, Inter, Playfair Display, Bebas Neue, Oswald)
- **Deployment**: Vercel (static site hosting)

## Key Features
1. **Landing Page**: Hero section, coaching services, testimonials, CTA
2. **Diagnostic Quiz**: Interactive React-based execution blocker assessment
3. **Responsive Design**: Mobile-first approach with fluid typography
4. **Theme System**: CSS custom properties for consistent theming
5. **Performance Optimized**: Font preloading, asset caching

## CSS Architecture
- **Design System**: CSS custom properties for colors, spacing, typography
- **Responsive Typography**: clamp() functions for fluid scaling
- **Component-based**: Modular CSS patterns
- **Theme Support**: Light/dark theme variables defined

## JavaScript Functionality
- **Quiz App**: React-based interactive diagnostic
- **Form Handling**: Contact forms and booking integration
- **Smooth Scrolling**: Navigation and anchor links
- **Interactive Elements**: Hover states, transitions, micro-interactions

## Integration Points
- **MailerLite API**: Email marketing integration
- **GoHighLevel**: Potential webhook integration
- **Zapier**: Automation workflows
- **Vercel Analytics**: Performance monitoring

## Performance Considerations
- Static site generation (no build step required)
- Optimized font loading with preconnect
- Asset caching headers for static resources
- Minimal JavaScript footprint (except quiz page)

## SEO & Accessibility
- Semantic HTML5 structure
- Meta tags for social sharing
- Responsive design for all devices
- Alt tags for images
- Proper heading hierarchy

---
*Generated for Codex review - May 2025*
