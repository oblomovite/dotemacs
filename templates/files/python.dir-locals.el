((python-mode
  . ((eglot-workspace-configuration
      . ((:pyls . (:plugins (:jedi_completion (:include_params t)))))))))

;; # for import sorting
;; pip install pyls-isort
;; # for mypy checking (python 3.4+ is needed)
;; pip install pyls-mypy
;; # for formating with black
;; pip install pyls-black
;; # for detecting the use of deprecated apis
;; pip install pyls-memestra
;; syntax checking
;; pip install flake8 
;; for dap mode
;; pip install "ptvsd>=4.2"
;; import magic functionality
;; pip install importmagic epc
;; remove unused imports
;; autoflake
;; consider pyright vs pyls
;; pip install pyright
