if _command_exists oh-my-posh; then
  eval "$(oh-my-posh init bash --config ~/.bash_it/custom/themes/omp-marcola/night-owl-marcola.omp.json)"

  function _omp_hook() {
      local ret=$__bp_last_ret_value
      local omp_stack_count=$((${#DIRSTACK[@]} - 1))
      local omp_elapsed=-1
      if [[ -n "$omp_start_time" ]]; then
          local omp_now=$(/usr/local/bin/oh-my-posh get millis --shell=bash)
          omp_elapsed=$((omp_now-omp_start_time))
          omp_start_time=""
      fi
      set_poshcontext
      PS1="$(/usr/local/bin/oh-my-posh print primary --config="$POSH_THEME" --shell=bash --shell-version="$BASH_VERSION" --error="$ret" --execution-time="$omp_elapsed" --stack-count="$omp_stack_count" | tr -d '\0')"
      return $ret
  }
else
  _log_warning "The oh-my-posh binary was not found on your PATH. Falling back to your existing PS1, please see the docs for more info."
fi

