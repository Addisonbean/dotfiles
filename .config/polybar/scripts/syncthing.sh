#!/usr/bin/env bash

connected="$(curl -s -H "X-API-Key: $SYNCTHING_API_KEY" localhost:8384/rest/system/connections | jq '.connections['\""$SYNCTHING_PHONE_ID"\"]'.connected')"

# connected="$(curl -s -H "X-API-Key: 9ZfWkKFfPofQNez9wW5SieaYa7ionvAd" localhost:8384/rest/system/connections | jq '.connections["ZKUZIM6-5NT7BTL-BCND7PV-COLM5YP-JZTUOBC-XJEPJUB-XELMNPY-HTRG2A4"].connected')"

if [ "$connected" = "true" ]; then
    echo "%{T2}%{T-}"
else
    echo "%{T2}%{T-}"
fi
