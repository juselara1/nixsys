#!/usr/bin/env bash

get_password() {
	pushd "${HOME}/.password-store/" > /dev/null
	local accounts=`find "." -not -path '*/.*' -type "f" | sed 's#\./##g' | sed 's/\.gpg//g'`
	popd > /dev/null
	local selected_account=`echo -e "${accounts[@]}" | fzf` && pass -c "${selected_account}"
}
