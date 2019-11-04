Description
* Result of bot sweeping will be kept in `*.log` files.
* Result of bot counting will be kept in `*_sum.txt` files.

Setup & Installing
* `virtualenv --python python3 ~/envs/robot`
* `source ~/envs/robot/bin/activate`
* `pip install -r requirements.txt`
* Try run `robot ig.robot` and it will show a error result.
* Download `chromedriver` from URL display in error result.
* `export PATH=.:$PATH` or `nano ~/bash_profile` in MacOS.
* Edit variable parameter at `config.py` file.
* `robot ig.robot` for normal run a script.
* `pabot *.robot` for parallel run scripts.
* All Results should be PASSED and display in GREEN colored text.

For learning
* `ig.robot`: You'll learn how to login instagram before go to any post.
* `tw.robot`: You'll learn how to scroll webpage.