# 4REVERgunner 🔫

**Endless 3D browser shooter** — survive infinite waves of enemies. Built with [Three.js](https://threejs.org/).

---

## ▶ Play Now

1. **Clone or download this repo**
   ```bash
   git clone https://github.com/tbeetech/4REVERgunner.git
   ```
2. **Open `index.html` in any modern web browser** (Chrome, Firefox, Edge, Safari)
   - No install, no build step, no server needed.
   - Requires an internet connection the first time to load Three.js from CDN.

---

## 🎮 Controls

| Input | Action |
|-------|--------|
| `W A S D` | Move player |
| `Mouse` | Aim |
| `Left Click` (hold) | Auto-fire |

---

## ⚔️ Enemies

| Type | Color | Description |
|------|-------|-------------|
| **Basic** | 🔴 Red | Standard chaser — 2 HP |
| **Fast** | 🟠 Orange | Quick but fragile — 1 HP (unlocks wave 3+) |
| **Tank** | 🟣 Purple | Slow but very tough — 6 HP (unlocks wave 5+) |

---

## 📈 Wave System

- **Wave 1** starts with 5 enemies; each new wave adds 3 more.
- Enemies get faster as waves increase.
- A 2.8-second breather between waves — use it wisely.
- More enemy types unlock as you progress.

---

## 🏆 Scoring

| Kill | Points |
|------|--------|
| Basic enemy | 10 |
| Fast enemy | 15 |
| Tank enemy | 30 |

---

## 🛠 Tech Stack

- **Three.js r160** (loaded via CDN — no npm required)
- Vanilla HTML / CSS / JavaScript — single `index.html` file

---

*How long can you last?*
