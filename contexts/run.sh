if [ -z "$NAMES" ]; then
  echo "WARNING: Specify one or more names in NAMES"
  exit 0
fi

mkdir -p /workplace
cd /workplace

echo "*
!*.pub" > .ignore

echo "Creating keys include: "
echo $NAMES | tr -s : \\n

date -Is
for i in $(seq 1e7); do
    find -name "id_*" -type f | xargs rm -rf
    seq 1e5 | SHELL=/bin/sh split -u -n r/48 --filter 'while read n; do ssh-keygen -t ed25519 -f id_ed_$n -N "" -C "" > /dev/null; done'

    for name in $(echo $NAMES | tr -s : \\n); do
        if [ -n "$(ag $name)" ]; then
            mkdir -p /keys/$name
            ag $name | cut -d":" -f 1 | cut -d"." -f 1 | xargs -I {} /bin/bash -c "cp {} /keys/$name/$i{} && cp {}.pub /keys/$name/$i{}.pub"
            echo "Got a key for: $name"
        fi
    done
    echo $(date -Is) - $i
done
