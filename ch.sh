#!/bin/bash

for f in *.sh; do
	sed -i -- 's/"\${HOME}\/zynthian\/zynthian\-sw"/\$ZYNTHIAN_SW_DIR/' $f
	sed -i -- 's/"\${HOME}"\/zynthian\/zynthian\-sw/\$ZYNTHIAN_SW_DIR/' $f
	sed -i -- 's/"\${HOME}"\/zynthian\/zynthian\-recipe/\$ZYNTHIAN_RECIPE_DIR/' $f
done
