#!/usr/bin/env bash

cd

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev openjdk-8-jdk libncurses5 repo

cd

mkdir bliss

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

cd $HOME/bliss

repo init -u https://github.com/BlissRoms/platform_manifest.git -b q

repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j8

rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf hardware/qcom/sdm845
rm -rf kernel/google/bonito
rm -rf vendor/google
rm -rf vendor/images
rm -rf vendor/gapps

git clone https://github.com/stebomurkn420/Bonito -b bliss device/google/bonito
git clone https://android.googlesource.com/device/google/bonito-sepolicy -b android-10.0.0_r12 device/google/bonito-sepolicy
git clone https://github.com/TheMuppets/proprietary_vendor_google vendor/google
git clone https://github.com/LineageOS/android_kernel_google_msm-4.9 kernel/google/msm-4.9
git clone https://gitlab.com/shagbag913/vendor_gapps.git -b lineage-17.0 vendor/gapps
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_display hardware/qcom/sdm710/display
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_gps hardware/qcom/sdm710/gps
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_media hardware/qcom/sdm710/media
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/thermal -b android-9.0.0_r47 hardware/qcom/sdm710/thermal
git clone https://android.googlesource.com/platform/hardware/qcom/sdm710/vr -b android-9.0.0_r47 hardware/qcom/sdm710/vr
git clone https://github.com/stebomurkn420/sdm710_hardware_qcom_data_ipacfg-mgr -b bliss hardware/qcom/sdm710/data/ipacfg-mgr

cd $HOME/bliss

. build/envsetup.sh
lunch bliss_bonito-userdebug
make blissify -j32 |& tee /tmp/build.log
