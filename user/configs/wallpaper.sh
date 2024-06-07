function animate() {
	local GIF_PATH="${HOME}/.config/home-manager/configs/wallpaper.gif"
	local IMG_PATH="${HOME}/.wallpaper/"
	local REFRESH_RATE="0.1"

	if [[ ! -d "${IMG_PATH}" ]]; then
		mkdir "${IMG_PATH}"
		convert "$GIF_PATH" -coalesce "${IMG_PATH}/%03d.png"
	fi
	while true; do
		for image in `ls "${IMG_PATH}/"`; do
			feh --bg-scale "${IMG_PATH}/${image}" || exit 1
			sleep "${REFRESH_RATE}"
		done
	done
}

animate
