#!/bin/bash

echo "🚀 Սկսվում է Wings-ի լրիվ (FULL) ռեբրենդինգը դեպի Shadowdactyl..."

# 1. ԳԻԹՀԱԲԻ ՀՂՈՒՄՆԵՐԻ ԵՎ GO MODULE-ՆԵՐԻ ՓՈԽԱՐԻՆՈՒՄ
echo "🔗 Փոխարինվում են GitHub-ի բոլոր հղումները և Go Import-ները..."
find . -type f -not -path '*/.git/*' -exec sed -i 's|github.com/ShadowsDevs/wings|github.com/ShadowsDevs/wings|g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's|httpsgithub.com/ShadowsDevs/wings|httpsgithub.com/ShadowsDevs/wings|g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's|https://github.com/ShadowsDevs/wings|httpsgithub.com/ShadowsDevs/wings/ShadowsDevs/wings|g' {} +

# 2. ՓՈԽԱՐԻՆՈՒՄ ՖԱՅԼԵՐԻ ՆԵՐՍՈՒՄ (ՏԵՔՍՏԵՐ ԵՎ ԿՈԴ)
echo "📝 Փոխարինվում են անվանումները ֆայլերի ներսում..."
find . -type f -not -path '*/.git/*' -exec sed -i 's/shadowdactyl/shadowdactyl/g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's/Shadowdactyl/Shadowdactyl/g' {} +
find . -type f -not -path '*/.git/*' -exec sed -i 's/SHADOWDACTYL/SHADOWDACTYL/g' {} +

# 3. ՖԱՅԼԵՐԻ ԵՎ ԹՂԹԱՊԱՆԱԿՆԵՐԻ (FOLDERS) ԱՆՎԱՆԱՓՈԽՈՒՄ (Խորքից դեպի վերև)
echo "📁 Անվանափոխվում են Wings-ի ֆայլերն ու թղթապանակները..."

# Փոքրատառ shadowdactyl -> shadowdactyl
find . -depth -name "*shadowdactyl*" -not -path '*/.git/*' -exec bash -c '
  for item; do
    dir=$(dirname "$item")
    base=$(basename "$item")
    new_base="${base//shadowdactyl/shadowdactyl}"
    mv "$item" "$dir/$new_base"
  done
' _ {} +

# Մեծատառ Shadowdactyl -> Shadowdactyl
find . -depth -name "*Shadowdactyl*" -not -path '*/.git/*' -exec bash -c '
  for item; do
    dir=$(dirname "$item")
    base=$(basename "$item")
    new_base="${base//Shadowdactyl/Shadowdactyl}"
    mv "$item" "$dir/$new_base"
  done
' _ {} +

# Ամբողջությամբ մեծատառ SHADOWDACTYL -> SHADOWDACTYL
find . -depth -name "*SHADOWDACTYL*" -not -path '*/.git/*' -exec bash -c '
  for item; do
    dir=$(dirname "$item")
    base=$(basename "$item")
    new_base="${base//SHADOWDACTYL/SHADOWDACTYL}"
    mv "$item" "$dir/$new_base"
  done
' _ {} +

# 4. GO DEPENDENCIES-Ի ԹԱՐՄԱՑՈՒՄ
echo "⚙️ Թարմացվում և ստուգվում են Go մոդուլները..."
go mod tidy

echo "✅ Wings-ի FULL ռեբրենդինգը հաջողությամբ ավարտվեց:"
