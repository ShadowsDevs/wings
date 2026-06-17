#!/bin/bash

echo "🚀 Սկսվում է Wings-ի լրիվ (FULL) ռեբրենդինգը դեպի Shadowdactyl..."

# 1. ԳԻԹՀԱԲԻ ՀՂՈՒՄՆԵՐԻ ԵՎ GO MODULE-ՆԵՐԻ ՓՈԽԱՐԻՆՈՒՄ
echo "🔗 Փոխարինվում են GitHub-ի բոլոր հղումները և Go Import-ները..."
find . -type f -not -path '*/.git/*' -exec sed -i 's|://github.com|github.com/ShadowsDevs/wings|g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's|https://github.com|https://github.com|g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's|https://://github.com|https://github.com/ShadowsDevs/wings|g' {} +

# 2. ՓՈԽԱՐԻՆՈՒՄ ՖԱՅԼԵՐԻ ՆԵՐՍՈՒՄ (ՏԵՔՍՏԵՐ ԵՎ ԿՈԴ)
echo "📝 Փոխարինվում են անվանումները ֆայլերի ներսում..."
find . -type f -not -path '*/.git/*' -exec sed -i 's/pterodactyl/shadowdactyl/g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's/Pterodactyl/Shadowdactyl/g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's/PTERODACTYL/SHADOWDACTYL/g' {} +

# 3. ՖԱՅԼԵՐԻ ԵՎ ԹՂԹԱՊԱՆԱԿՆԵՐԻ (FOLDERS) ԱՆՎԱՆԱՓՈԽՈՒՄ (Խորքից դեպի վերև)
echo "📁 Անվանափոխվում են Wings-ի ֆայլերն ու թղթապանակները..."

# Փոքրատառ pterodactyl -> shadowdactyl
find . -depth -name "*pterodactyl*" -not -path '*/.git/*' -exec bash -c '
  for item; do
    dir=$(dirname "$item")
    base=$(basename "$item")
    new_base="${base//pterodactyl/shadowdactyl}"
    mv "$item" "$dir/$new_base"
  done
' _ {} +

# Մեծատառ Pterodactyl -> Shadowdactyl
find . -depth -name "*Pterodactyl*" -not -path '*/.git/*' -exec bash -c '
  for item; do
    dir=$(dirname "$item")
    base=$(basename "$item")
    new_base="${base//Pterodactyl/Shadowdactyl}"
    mv "$item" "$dir/$new_base"
  done
' _ {} +

# Ամբողջությամբ մեծատառ PTERODACTYL -> SHADOWDACTYL
find . -depth -name "*PTERODACTYL*" -not -path '*/.git/*' -exec bash -c '
  for item; do
    dir=$(dirname "$item")
    base=$(basename "$item")
    new_base="${base//PTERODACTYL/SHADOWDACTYL}"
    mv "$item" "$dir/$new_base"
  done
' _ {} +

# 4. GO DEPENDENCIES-Ի ԹԱՐՄԱՑՈՒՄ
echo "⚙️ Թարմացվում և ստուգվում են Go մոդուլները..."
go mod tidy

echo "✅ Wings-ի FULL ռեբրենդինգը հաջողությամբ ավարտվեց:"
