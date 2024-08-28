kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
    // 클릭한 위도, 경도 정보를 가져옵니다
    let latLng = mouseEvent.latLng;

    //map.setCenter(latlng);
    map.panTo(latLng);

    const clickLatLng = {
        latitude: latLng.getLat(),
        longitude: latLng.getLng(),
        zoomLevel: map.getLevel(),
    }

    onMapTap.postMessage(JSON.stringify(clickLatLng));
});