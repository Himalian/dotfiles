# ~/.config/fish/completions/nix.fish
# completions for lix, A community fork of nix


function _nix_complete
  set -l nix_args (commandline --current-process --tokenize --cut-at-cursor)
  set -l current_token (commandline --current-token --cut-at-cursor)
  
  set -l nix_arg_to_complete (count $nix_args)

  env NIX_GET_COMPLETIONS=$nix_arg_to_complete $nix_args $current_token 2>/dev/null
end

function _nix_accepts_files
  set -l response (_nix_complete)
  test $response[1] = 'filenames'
end

function _nix
  set -l response (_nix_complete)
  
  if set -q response[2]
      string replace -r '\t.*$' '' -- $response[2..-1]
  end
end

complete --command nix --condition 'not _nix_accepts_files' --no-files
complete --command nix --arguments '(_nix)'
