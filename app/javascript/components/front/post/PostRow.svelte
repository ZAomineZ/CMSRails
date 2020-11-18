<script>
    // PROPS
    export let post = null
</script>

<div class="row-cell">
    <div class="view-row">
        <a href="#" title={post.name}>
            <img src={post.img_original.thumb.url} alt={post.name}>
        </a>
    </div>
    <div class="title-row">
        <div class="title-block">
            <h4>
                <a href="#">{post.name}</a>
            </h4>
        </div>
    </div>
</div>

