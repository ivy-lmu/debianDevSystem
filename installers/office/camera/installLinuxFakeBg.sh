#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pyv=3 #preferred python: yet fake.py supports 3.7-3.9
app="Linux-Fake-Background-Webcam"
if ! [ -d "${DIR}/${app}" ]; then
  git clone https://github.com/fangfufu/Linux-Fake-Background-Webcam.git
fi
cd "${DIR}/${app}"

echo "installing python env:"
sudo apt install "python${pyv}-pip" "python${pyv}-dev"
"pip${pyv}" install --upgrade pip
"pip${pyv}" install --user -r requirements.txt

echo "running on /dev/video2"
"python${pyv}" "${DIR}/${app}/fake.py"
