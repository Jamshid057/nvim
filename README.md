# Neovim Keymap'lar - To'liq Ro'yxat

Bu fayl sizning Neovim konfiguratsiyangizdagi barcha keymap'larni o'z ichiga oladi.

**Leader Key:** `<Space>` (bo'sh joy)



---

##  Theme almashtirish

    :colorscheme

choose from themes in list


---

## 📁 Fayl Boshqaruvi

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>pv` | `n` | Netrw file explorer'ni ochish/yopish |
| `<C-n>` | `n` | Neo-tree filesystem toggle |
| `<leader>ff` | `n` | Telescope: Fayllarni qidirish |
| `<C-p>` | `n` | Telescope: Git fayllarini qidirish |
| `<leader>ps` | `n` | Telescope: Grep string qidirish |

---

## 📝 Kod Tahrirlash

### Qatorlar bilan ishlash

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `J` | `n` | Quyidagi qatorni birlashtirish (cursor mark bilan) |
| `J` | `v` | Tanlangan qatorni pastga ko'chirish |
| `K` | `v` | Tanlangan qatorni yuqoriga ko'chirish |
| `<S-j>` | `n` | Qatorni pastga ko'chirish |
| `<S-k>` | `n` | Qatorni yuqoriga ko'chirish |
| `<S-j>` | `v` | Tanlangan qatorni pastga ko'chirish |
| `<S-k>` | `v` | Tanlangan qatorni yuqoriga ko'chirish |
| `H` | `n`, `v` | Qator boshiga o'tish (PyCharm-style) |
| `L` | `n`, `v` | Qator oxiriga o'tish (PyCharm-style) |

### Scroll va Navigation

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<C-d>` | `n` | Pastga scroll qilish (cursor mark bilan) |
| `<C-u>` | `n` | Yuqoriga scroll qilish (cursor mark bilan) |
| `n` | `n` | Keyingi qidiruv natijasiga o'tish (cursor mark bilan) |
| `N` | `n` | Oldingi qidiruv natijasiga o'tish (cursor mark bilan) |

### Copy/Paste

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>p` | `x` | Paste qilish (delete register'ga yozmasdan) |
| `<leader>y` | `n`, `v` | System clipboard'ga copy qilish (`+y`) |
| `<leader>Y` | `n` | Qatorni system clipboard'ga copy qilish |
| `<leader>d` | `n`, `v` | Delete qilish (delete register'ga yozmasdan) |

### Find va Replace

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>s` | `n` | Hozirgi so'zni barcha joylarda almashtirish |

### Comment (Komment qilish)

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `gcc` | `n` | Joriy qatorni komment qilish/olib tashlash |
| `gbc` | `n` | Joriy block'ni komment qilish/olib tashlash |
| `gc` | `v` | Tanlangan qatorlarni komment qilish/olib tashlash |
| `gb` | `v` | Tanlangan block'ni komment qilish/olib tashlash |
| `gcO` | `n` | Qator ustiga komment qo'shish |
| `gco` | `n` | Qator ostiga komment qo'shish |
| `gcA` | `n` | Qator oxiriga komment qo'shish |

**Misol:**
- Qator ustida `gcc` bosib komment qiling
- Bir nechta qatorni tanlab (Visual mode) `gc` bosib komment qiling
- Block tanlab `gb` bosib block komment qiling

---

## 🔧 LSP (Language Server Protocol)

### Asosiy LSP Funksiyalar

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `K` | `n` | Hover - Function/class haqida ma'lumot ko'rsatish |
| `gd` | `n` | Go to Definition - Definition'ga o'tish |
| `<leader>vws` | `n` | Workspace Symbol - Workspace'dagi symbol'larni qidirish |
| `<leader>vca` | `n` | Code Action - Kod yaxshilash takliflari |
| `<leader>vrr` | `n` | References - Qayerda ishlatilganini ko'rsatish |
| `<leader>vrn` | `n` | Rename - O'zgaruvchi/funktion nomini o'zgartirish |
| `<C-h>` | `i` | Signature Help - Function parametrlarini ko'rsatish (Insert mode) |

### Diagnostika (Diagnostics)

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>e` | `n` | Diagnostika ma'lumotini float window'da ko'rsatish |
| `<leader>vd` | `n` | Diagnostika ma'lumotini float window'da ko'rsatish |
| `[d` | `n` | Oldingi diagnostikaga o'tish |
| `]d` | `n` | Keyingi diagnostikaga o'tish |

### LSP Status

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>ls` | `n` | Ishlayotgan LSP serverlarni ko'rsatish |

---

## 🎨 Formatting

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>gf` | `n` | Kodni format qilish (null-ls orqali) |

**Formatting sozlamalari:**
- **Python:** Black + isort
- **Django templates:** djhtml
- **Lua:** stylua
- **HTML/CSS/JS:** prettier

---

## 🐛 Trouble (Diagnostika Panel)

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>tt` | `n` | Trouble panel'ni ochish/yopish |
| `[t` | `n` | Keyingi trouble item'ga o'tish |
| `]t` | `n` | Oldingi trouble item'ga o'tish |

---

## 📊 Quickfix va Location List

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<C-k>` | `n` | Quickfix: Keyingi xatoga o'tish |
| `<C-j>` | `n` | Quickfix: Oldingi xatoga o'tish |
| `<leader>k` | `n` | Location list: Keyingi item'ga o'tish |
| `<leader>j` | `n` | Location list: Oldingi item'ga o'tish |

---

## 🔄 Undo/Redo

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>u` | `n` | Undotree'ni ochish/yopish |

---

## 🔀 Git (Fugitive)

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>gs` | `n` | Git status'ni ko'rsatish |

---

## 📝 Blame

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>b` | `n` | Git blame window'ni toggle qilish |

---

## ⚙️ Utility

| Keymap | Mode | Tavsif |
|--------|------|--------|
| `<leader>x` | `n` | Hozirgi faylga execute permission berish |
| `<leader><leader>` | `n` | Neovim config'ni reload qilish (`:so`) |

---

## 📌 Eslatmalar

1. **Leader Key:** Barcha `<leader>` keymap'lar `<Space>` (bo'sh joy) bilan boshlanadi
2. **Mode belgilanishi:**
   - `n` = Normal mode
   - `v` = Visual mode
   - `i` = Insert mode
   - `x` = Visual mode (character-wise)
3. **LSP Keymap'lar:** Faqat LSP serverlar ishlayotgan buffer'larda ishlaydi
4. **Diagnostika:** Faqat **ruff** diagnostika ko'rsatadi (pyright va null-ls diagnostika o'chirilgan)

---

## 🔍 Qo'shimcha Ma'lumot

- **Hover (K):** Function/class haqida ma'lumot ko'rsatadi (rounded border, max width: 80)
- **Formatting:** null-ls orqali ishlaydi (Black, isort, djhtml, stylua, prettier)
- **Autocomplete:** pyright orqali ishlaydi (diagnostika o'chirilgan)
- **Diagnostika:** ruff orqali ishlaydi (faqat linting)

---

*Oxirgi yangilanish: 2026-01-15 *
