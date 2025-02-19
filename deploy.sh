if [ "$1" != "--not-pull" ]; then
    echo "Run git pull..."
    git pull
fi

sudo docker-compose -f docker-compose.production.temp.yml up -d


# This loop will run indefinitely until we get a 200 response
while true; do
    # Use curl to get the HTTP status code
    status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000)

    # Check if status code is 200
    if [ "$status" -eq 200 ]; then
        echo "Server started!"
        break
    else
        echo "Status: $status. wait..."
        # Wait for 1 second before next try
        sleep 1
    fi
done

