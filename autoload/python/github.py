import vim
import re

def searchValueFromKey(key, res):
    match = re.search('"{}": "(.*)"'.format(key), res, re.IGNORECASE)
    if match:
        message = match.group(1)
        return (message)
    return ("")

def checkAuth():
    res = vim.eval("l:res")
    msg = searchValueFromKey("message", res)
    login = searchValueFromKey("login", res)
    if (login):
        print("Authenticated !")
        vim.command('let g:tissue_authenticated = 1')
    else:
        print(msg)
