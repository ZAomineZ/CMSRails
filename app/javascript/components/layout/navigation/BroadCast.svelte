<script>
    export let title = ''
    export let content = ''
</script>

<div class="row">
    <div class="col-md-12">
        <div class="title-page-contain">
            <nav>
                <ol class="navigation">
                    <li class="navigation-item">
                        <a href="/">Home</a>
                    </li>
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