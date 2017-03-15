# buildozo
A docker image to build Kivy applications to Android with Buildozer

Installation:

```shell
# set DEV_DIR enviroment variable with the directory you store your sources
export DEV_DIR=/path/to/your/sources/
# Clone it
git clone https://github.com/gstsistemas/buildozo/
cd buildozo
# Build it
./build
# Then you can run with:
./run

```

Once inside the container, you can build an APK with buildozer as follows:


```shell

cd /devel/your_source_dir
buildozer android debug

```
It mounts /devel inside container to your DEV_DIR. So you can find your code there.

During image building, it clones an kivy project and compiles that, does this in order to test if building is OK and also to populate .buildozer directory.

I hope it helps you.
