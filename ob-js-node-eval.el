;;; ob-js-node-eval.el --- `:results node-eval' for ob-js  -*- lexical-binding:t -*-

;; Copyright (C) 2023-present CHEN Xian'an (a.k.a `realazy').

;; Maintainer: xianan.chen@gmail.com

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Output a value with `node -p', which can be used to avoid using
;; redundant `return' in a JavaScript expression if you want to
;; produce `:results value' in `ob-js'.

;;; Code:

(defun ob-js-node-eval/org-babel-execute:js/around (orig-fn body params)
  (cond
   ((member "node-eval" (map-elt params :result-params))
    (with-temp-buffer
      (insert (org-babel-expand-body:generic
		           body params (org-babel-variable-assignments:js params)))
      (goto-char (point-min))
      (let ((cmd 
             (if (or (string= "esm" (cdr (assq :module params)))
                     (search-forward "import " nil t))
                 "node --input-type=module -"
               "node -")))
        (shell-command-on-region (point-min) (point-max) cmd nil t))
      (buffer-string)))
   (t (funcall orig-fn body params))))

(with-eval-after-load 'ob-js
  (advice-add 'org-babel-execute:js :around
              #'ob-js-node-eval/org-babel-execute:js/around))

(provide 'ob-js-node-eval)

;;; ob-js-node-eval.el ends here
