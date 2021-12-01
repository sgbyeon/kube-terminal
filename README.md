# kube-terminal
* kubectx, kubens, kube-ps1 설치
* .bashrc 파일에 bash_completion, PS1 세팅

## alias 정보
```
alias k='kubectl'
alias kall='kubectl get all --all-namespaces'
alias kns='kubens'
alias kx='kubectx'
```
---

## 사용방법
```
git clone https://github.com/sgbyeon/kube-terminal.git
cd kube-terminal
bash kube-terminal.sh
source ~/.bashrc
```
---

## 삭제방법
#### 관련 바이너리 및 스크립특 삭제
```
rm -fv /usr/bin/{kubectx,kubens,kubectl,kube-ps1.sh}
rm -rf kube-terminal
```
#### ~/.bashrc 에서 아래의 내용 삭제
```
# for kubernetes
alias k='kubectl'
source <(k completion bash)
complete -F __start_kubectl k

alias kall='kubectl get all --all-namespaces'
alias kx='kubectx'
alias kns='kubens'

source /usr/bin/kube-ps1.sh
PS1='[\u@\h \W $(kube_ps1)]# '
```
#### PS1 적용
```
source ~/.bashrc
```
---
![kube-terminal](https://user-images.githubusercontent.com/31094223/144174538-5abe48f7-3012-4d69-9fad-44096cefeeb4.JPG)
##  PS1에서 Symbol 제거
#### Putty와 같이 Unicode Character가 깨지는 것이 보기 싫을 경우 symbol을 제거하는 방법
/usr/bin/kube-ps1.sh 파일에서 kube_ps1() 함수에서 Symbol 부분을 아래와 같이 주석 처리
```
  # Symbol
  #KUBE_PS1+="$(_kube_ps1_color_fg $KUBE_PS1_SYMBOL_COLOR)$(_kube_ps1_symbol)${KUBE_PS1_RESET_COLOR}"

  #if [[ -n "${KUBE_PS1_SEPARATOR}" ]] && [[ "${KUBE_PS1_SYMBOL_ENABLE}" == true ]]; then
  #  KUBE_PS1+="${KUBE_PS1_SEPARATOR}"
  #fi
```
주석 처리 및 저장 후 source 명령어를 이용하여 .bashrc 재적용
```
source ~/.bashrc
```
