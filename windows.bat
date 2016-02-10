cd /d %~dp0
git config --global core.eol lf
git config --global core.autocrlf input
git rm -rf --cached .
git reset --hard HEAD