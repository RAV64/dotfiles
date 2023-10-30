import os
import shutil
import sys
from typing import TypedDict

DIR = os.curdir
USER_DIR = f"/Users/{os.environ['USER']}"

FF_PROFILES_DIR = f"{USER_DIR}/Library/Application Support/Firefox/Profiles"
FF_PROFILES = os.listdir(FF_PROFILES_DIR)

input("Make sure any instances of Firefox are closed")


class Repo(TypedDict):
    name: str
    url: str
    dir: str


ARKENFOX: Repo = {
    "name": "Arkenfox",
    "url": "https://github.com/arkenfox/user.js",
    "dir": f"{USER_DIR}/dotfiles/firefox/arkenfox",
}

try:
    shutil.copy2(
        f"{USER_DIR}/dotfiles/firefox/arkenfox-overrides.js",
        f"{ARKENFOX['dir']}/user-overrides.js",
    )
except FileNotFoundError:
    print(
        f"""❗️ERROR: You're missing arkenfox-overrides.js file in 
        {USER_DIR}/dotfiles/firefox/
        https://github.com/arkenfox/user.js/wiki/3.1-Overrides"""
    )
    exit()


CASCADE: Repo = {
    "name": "Cascade",
    "url": "https://github.com/andreasgrafen/cascade",
    "dir": f"{USER_DIR}/dotfiles/firefox/cascade",
}

try:
    with open(f"{USER_DIR}/dotfiles/firefox/cascade-overrides.css", "r") as f:
        OVERRIDE_CASCADE = f.readlines()
except FileNotFoundError:
    print(
        f"""❗️ERROR: You're missing cascade-overrides.css file in 
        {USER_DIR}/dotfiles/firefox/"""
    )
    exit()


def get_profile_dir():
    ff_profile = ""
    if len(sys.argv) == 1:
        ff_profile = FF_PROFILES[
            int(
                input(
                    "Choose FF profile to install Cascade & Arkenfox for:\n\n"
                    + "\n".join(
                        [f"{i}: {prof}" for i, prof in enumerate(FF_PROFILES, 1)]
                    )
                    + "\n\n"
                )
            )
            - 1
        ]
    else:
        for prof in FF_PROFILES:
            if sys.argv[1] in prof:
                ff_profile = prof

    if ff_profile == "":
        print("❗️Profile passed as argument which was not found")
        exit()
    return f"{FF_PROFILES_DIR}/{ff_profile}"


profile_dir = get_profile_dir()
print(f"❗️Changes will be made to:\n{profile_dir}")


def update_repository(repo: Repo):
    print(f"\n❗️Updating: {repo['name']}\n")
    if os.path.exists(repo["dir"]):
        os.chdir(repo["dir"])
        os.system(f"git pull {repo['url']}")
        os.chdir(DIR)
    else:
        os.system(f"git clone {repo['url']} {repo['dir']}")


update_repository(ARKENFOX)
update_repository(CASCADE)


def install_arkenfox():
    print("\n❗️Installing Arkenfox...\n")

    print("❗️Copying files to profile")
    for file in ["prefsCleaner.sh", "updater.sh", "user.js", "user-overrides.js"]:
        shutil.copy2(f"{ARKENFOX['dir']}/{file}", profile_dir)

    os.chdir(profile_dir)
    print("❗️Running update.sh")
    os.system("bash updater.sh")
    print("❗️Running prefsCleaner.sh")
    os.system("bash prefsCleaner.sh")

    print("\n❗️Arkenfox is now installed\n")


def install_cascade():
    print("\n❗️Installing Cascade...\n")
    print("❗️Copying files to profile")

    shutil.copytree(
        f"{CASCADE['dir']}/chrome", f"{profile_dir}/chrome", dirs_exist_ok=True
    )

    with open(f"{profile_dir}/chrome/userChrome.css", "a") as f:
        f.writelines(OVERRIDE_CASCADE)

    print("❗️Appending overrides to userChrome.css")
    print("\n❗️Cascade is now installed\n")


install_arkenfox()
install_cascade()

print("\n❗️Done")
