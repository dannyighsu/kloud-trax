$(document).ready(function() {

    // Play track on double click
    $("li.track").dblclick(function() {
        audio = document.getElementById("audio");
        audio.src = $(this).data('url');
        $("#album-art").src = $(this).data('album-art');

        pause();
        audio.load();
        play();
        getTrackInfo($(this));

        /* link = $.get(
            "https://api.kloudless.com/v0/accounts/" + account_id + "keys",
            {headers: {"Authorization": "AccountKey " + accountkey,
            "Content-Type": "application/json"},
            body: {"file_id": file_id}}
        );
        alert(link);
        link = link['url'];
        $("#audio").src = link;*/
    });

    // Event callback upon completion of track download
    audio.addEventListener('loadedmetadata', function() {
    });

})

function getTrackInfo(track) {
    url = 'https://api.kloudless.com/l/MGtiJW4rggzn6ou5F251';
    // url = track.data('url');
    ID3.loadTags(url, function() {
        var tags = ID3.getAllTags(url);
        alert(tags.artist + " - " + tags.title + ", " + tags.album);
    });
}
