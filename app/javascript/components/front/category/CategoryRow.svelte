<script>
    // PROPS
    export let category = null
</script>

<div class="row-cell">
    <div class="view-row">
        <a href="#" title={category.slug}>
            <img src={category.img_original.thumb.url} alt={category.name}>
        </a>
    </div>
    <div class="title-row">
        <h4>
            <a href="#">{category.name}</a>
        </h4>
    </div>
</div>