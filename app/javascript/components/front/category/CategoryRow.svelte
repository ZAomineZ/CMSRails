<script>
    // PROPS
    export let category = null
</script>

<div class="row-cell">
    <div class="view-row">
        <a href="/coloriage/{category.slug}" title={category.slug}>
            <img src={category.avat_cat.url} alt={category.name}>
        </a>
    </div>
    <div class="title-row">
        <div class="title-block">
            <h4>
                <a href="/coloriage/{category.slug}">{category.name}</a>
            </h4>
        </div>
    </div>
</div>