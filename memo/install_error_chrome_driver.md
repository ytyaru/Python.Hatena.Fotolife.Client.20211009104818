# chromedriver-binary インストールに失敗したログ

```sh
pip3 install selenium
pip3 install chromedriver-binary
```

```sh
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Collecting chromedriver-binary
  Downloading https://files.pythonhosted.org/packages/8b/c5/77a9822034f3e7c244dab99f92a7a4923ac4372623eca9bf683801c17003/chromedriver-binary-95.0.4638.17.0.tar.gz
Building wheels for collected packages: chromedriver-binary
  Running setup.py bdist_wheel for chromedriver-binary ... error
  Complete output from command /usr/bin/python3 -u -c "import setuptools, tokenize;__file__='/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" bdist_wheel -d /tmp/pip-wheel-yhdfg6ec --python-tag cp37:
  running bdist_wheel
  running build
  running build_py
  
  Downloading Chromedriver...
  
  Traceback (most recent call last):
    File "<string>", line 1, in <module>
    File "/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py", line 84, in <module>
      cmdclass={'build_py': DownloadChromedriver}
    File "/usr/lib/python3/dist-packages/setuptools/__init__.py", line 145, in setup
      return distutils.core.setup(**attrs)
    File "/usr/lib/python3.7/distutils/core.py", line 148, in setup
      dist.run_commands()
    File "/usr/lib/python3.7/distutils/dist.py", line 966, in run_commands
      self.run_command(cmd)
    File "/usr/lib/python3.7/distutils/dist.py", line 985, in run_command
      cmd_obj.run()
    File "/usr/lib/python3/dist-packages/wheel/bdist_wheel.py", line 188, in run
      self.run_command('build')
    File "/usr/lib/python3.7/distutils/cmd.py", line 313, in run_command
      self.distribution.run_command(command)
    File "/usr/lib/python3.7/distutils/dist.py", line 985, in run_command
      cmd_obj.run()
    File "/usr/lib/python3.7/distutils/command/build.py", line 135, in run
      self.run_command(cmd_name)
    File "/usr/lib/python3.7/distutils/cmd.py", line 313, in run_command
      self.distribution.run_command(command)
    File "/usr/lib/python3.7/distutils/dist.py", line 985, in run_command
      cmd_obj.run()
    File "/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py", line 42, in run
      url = get_chromedriver_url(version=chromedriver_version)
    File "/tmp/pip-install-dgv6d01o/chromedriver-binary/chromedriver_binary/utils.py", line 57, in get_chromedriver_url
      raise RuntimeError('Could not determine chromedriver download URL for this platform.')
  RuntimeError: Could not determine chromedriver download URL for this platform.
  
  ----------------------------------------
  Failed building wheel for chromedriver-binary
  Running setup.py clean for chromedriver-binary
Failed to build chromedriver-binary
Installing collected packages: chromedriver-binary
  Running setup.py install for chromedriver-binary ... error
    Complete output from command /usr/bin/python3 -u -c "import setuptools, tokenize;__file__='/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-record-0w4awj1b/install-record.txt --single-version-externally-managed --compile --user --prefix=:
    running install
    running build
    running build_py
    
    Downloading Chromedriver...
    
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py", line 84, in <module>
        cmdclass={'build_py': DownloadChromedriver}
      File "/usr/lib/python3/dist-packages/setuptools/__init__.py", line 145, in setup
        return distutils.core.setup(**attrs)
      File "/usr/lib/python3.7/distutils/core.py", line 148, in setup
        dist.run_commands()
      File "/usr/lib/python3.7/distutils/dist.py", line 966, in run_commands
        self.run_command(cmd)
      File "/usr/lib/python3.7/distutils/dist.py", line 985, in run_command
        cmd_obj.run()
      File "/usr/lib/python3/dist-packages/setuptools/command/install.py", line 61, in run
        return orig.install.run(self)
      File "/usr/lib/python3.7/distutils/command/install.py", line 589, in run
        self.run_command('build')
      File "/usr/lib/python3.7/distutils/cmd.py", line 313, in run_command
        self.distribution.run_command(command)
      File "/usr/lib/python3.7/distutils/dist.py", line 985, in run_command
        cmd_obj.run()
      File "/usr/lib/python3.7/distutils/command/build.py", line 135, in run
        self.run_command(cmd_name)
      File "/usr/lib/python3.7/distutils/cmd.py", line 313, in run_command
        self.distribution.run_command(command)
      File "/usr/lib/python3.7/distutils/dist.py", line 985, in run_command
        cmd_obj.run()
      File "/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py", line 42, in run
        url = get_chromedriver_url(version=chromedriver_version)
      File "/tmp/pip-install-dgv6d01o/chromedriver-binary/chromedriver_binary/utils.py", line 57, in get_chromedriver_url
        raise RuntimeError('Could not determine chromedriver download URL for this platform.')
    RuntimeError: Could not determine chromedriver download URL for this platform.
    
    ----------------------------------------
Command "/usr/bin/python3 -u -c "import setuptools, tokenize;__file__='/tmp/pip-install-dgv6d01o/chromedriver-binary/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-record-0w4awj1b/install-record.txt --single-version-externally-managed --compile --user --prefix=" failed with error code 1 in /tmp/pip-install-dgv6d01o/chromedriver-binary/
```

　以下がポイントと思われる。

```sh
  RuntimeError: Could not determine chromedriver download URL for this platform.
  
  ----------------------------------------
  Failed building wheel for chromedriver-binary
```

　私の環境はRaspberry PI 4B。たぶんARMv7用バイナリがないのだろう。

* [Ubuntu 20.10 on Raspberry Pi 4B にSeleniumの環境を構築してスクレイピング　その１：環境構築とお試し](https://shuzo-kino.hateblo.jp/entry/2021/02/15/235827)
* [ARMでChromeDriverをコンパイルする](https://stackoverflow.com/questions/38732822/compile-chromedriver-on-arm)
