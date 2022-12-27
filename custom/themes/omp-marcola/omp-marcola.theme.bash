if _command_exists oh-my-posh; then
	eval "$(oh-my-posh init bash --config ~/.bash_it/custom/themes/omp-marcola/night-owl-marcola.omp.json)"
	cd
else
	_log_warning "The oh-my-posh binary was not found on your PATH. Falling back to your existing PS1, please see the docs for more info."
fi

