trap_caught()
{
    rm $TMPDIR
}
trap trap_caught SIGINT SIGTERM

usage() {
cat << EOF
USAGE: ${0##*/} [options]
  options:
  -p | --prefix PREFIX               where to put executables (default: /usr/local/bin)
  -k | --kube-version KUBE_VERSION   the kubectl version to use or download
  --os-type OS_STRING                the os type to download darwin/window/linux binaries for
  --debug
EOF
}

get_os_type() {
    case "$OSTYPE" in
        darwin )
        OS_STRING="darwin"
        ;;
        linux-gnu|freebsd*)
        OS_STRING="linux"
        ;;
        cygwin | msys | mingw | win32 )
        OS_STRING="window"
        ;;
        * )
        echo "OSTYPE=$OSTYPE unknow not able to proceed"
        exit 1
        ;;
    esac
}

DEBUG=0

while [ "$1" != "" ] ; do
    case $1 in
        -p | --prefix )
            shift
            PREFIX="${1}"
            ;;
        -k | --kube-version )
            shift
            KUBE_VERSION="${1}"
            ;;
        --kubeconfig )
            shift
            export KUBECONFIG="${1}"
            ;;
        --os-type )
            shift
            OS_STRING="${1}"
            ;;
        -vvv | --debug )
            DEBUG=1
            ;;
        -h | --help )
            usage
            exit 0
            ;;
        * )
            CMD+=( "${1}" )
            ;;
    esac
shift
done

KUBE_VERSION="${KUBE_VERSION:-1.13.0}"
TMPDIR=$(mktemp -d)
PREFIX="${PREFIX:-/usr/local/bin}"
AWS_CLUSTER_NAME="${AWS_CLUSTER_NAME:-kube-1}"
AWS_REGION="${AWS_REGION:-us-east-1}"

print_out() {
    echo -e '\E[32m'"$@"'\E[0m'
}

set -e

if [ "$DEBUG" -eq "1" ]; then
    set -x
fi

if [ ! -d "$PREFIX" ]; then
    mkdir -p "$PREFIX"
fi

if [ -z "$OS_STRING" ] ; then
    get_os_type
fi

if ! which kubectl 2>&1 > /dev/null ; then
    # Add kubectl and clean up
    curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/${OS_STRING}/amd64/kubectl \
     -o ${TMPDIR}/kubectl && \
    chmod +x ${TMPDIR}/kubectl
    mv  ${TMPDIR}/kubectl "${PREFIX}/"
    kubectl version --client
fi

if ! which aws-iam-authenticator 2>&1 > /dev/null ; then
    # Get aws-iam-authenticator
    curl -L -o ${TMPDIR}/aws-iam-authenticator\
         https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/${OS_STRING}/amd64/aws-iam-authenticator
    chmod +x ${TMPDIR}/aws-iam-authenticator
    mv ${TMPDIR}/aws-iam-authenticator "${PREFIX}/"
fi

if ! which aws 2>&1 > /dev/null;  then
    TMP=$(mktemp)
    print_out "Installing awscli"
    pip install "awscli>=1.16.0" > $TMP || $(cat $TMP && rm $TMP && exit 1)
    print_out "Configure the awscli and then run:"
    print_out "   aws eks update-kubeconfig --name ${AWS_CLUSTER_NAME} --region ${AWS_REGION}"
    rm $TMP
else
    aws eks update-kubeconfig --name ${AWS_CLUSTER_NAME} --region ${AWS_REGION}
fi
