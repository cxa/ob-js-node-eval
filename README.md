# ob-js-node-eval

If you find that code is not running as you expect (will output `undefined` instead of `2`) in `org-babel-js` of Org Mode like this:

```org
#+begin_src js :results value
1+1
#+end_src
```

(To make it work, you must write `return 1+1`, which can be annoying)

You should try this little helper:

```org
#+begin_src js :results node-eval
1+1
#+end_src
```

This will simplify the process and produce the expected result.

## Install

Add `ob-js-node-eval.el` to your `load-path`, or use a package manager like `use-package` w/ `quelpa`:

```elisp
(use-package ob-js-node-eval
    :quelpa (ob-js-node-eval :fetcher github :repo "cxa/ob-js-node-eval"))
```
