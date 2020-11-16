<script>
    export let title = ''
    export let content = ''
    export let under_links = []
</script>

<div class="row">
    <div class="col-md-12">
        <div class="title-page-contain">
            <nav>
                <ol class="navigation">
                    <li class="navigation-item">
                        <a href="/admin">Home</a>
                    </li>
                    {#each under_links as under_link}
                        <li class="navigation-item">
                            <i class="fas fa-chevron-right icon-navigation-item icon-navigation-item-m"></i>
                            <a href={under_link.link}>{under_link.title}</a>
                        </li>
                    {/each}
                    <li class="navigation-item active">
                        <i class="fas fa-chevron-right icon-navigation-item icon-navigation-item-m"></i>
                        {title}
                    </li>
                </ol>
            </nav>
            <h3>{title}</h3>
            <p class="desc-page-contain">{content}</p>
        </div>
    </div>
</div>