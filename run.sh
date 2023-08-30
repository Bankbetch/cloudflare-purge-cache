# bin/bash

arg_h="[]"
arg_z=$CF_ZONE_ID
arg_e=$CF_EMAIL
arg_k=$CF_PURGE_CACHE_API_KEY

while getopts ":h:z:e:k:" opt; do
    case $opt in
        h)
            arg_h="$OPTARG"
        ;;
        z)
            arg_z="$OPTARG"
        ;;
        e)
            arg_e="$OPTARG"
        ;;
        k)
            arg_k="$OPTARG"
        ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
        ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
        ;;
    esac
done


CF_HOST=$arg_h

push_value() {
    local new_value="$1"

    CF_HOST="${CF_HOST%]}"

    if [ "${CF_HOST: -1}" != "[" ]; then
        CF_HOST="$CF_HOST,"
    fi

    CF_HOST="$CF_HOST\"$new_value\""
    CF_HOST="$CF_HOST]"
}

purge_cache() {
    response=$(curl -X POST \
        -H 'Content-Type: application/json' \
        -H "X-Auth-Email: $CF_EMAIL" \
        -H "Authorization: Bearer $CF_PURGE_CACHE_API_KEY" \
        --data '{
                    "files": '$CF_HOST'
        }' \
    -w "\n%{http_code}" https://api.cloudflare.com/client/v4/zones/$arg_z/purge_cache)

    response_code=$(echo "$response" | awk 'END {print $NF}')
    response_body=$(echo "$response" | awk 'NR==1')

    echo $response_body

    if [[ $response_code -eq 200 ]]; then
        exit 0
    else
        exit 1
    fi
}

purge_cache