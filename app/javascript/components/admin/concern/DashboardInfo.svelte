<script>
    // PROPS
    export let title = ''
    export let content = ''
</script>

<div class="row">
    <div class="col-md-12">
        <div class="card bg-info text-white">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 info-container-text">
                        <h5 class="card-title">{title}</h5>
                        <p>{content}</p>
                        <ul>
                            <li>You can create and edit your post !</li>
                            <li>You can create and edit your categories !</li>
                            <li>You can see the listening to your posts and categories !</li>
                        </ul>
                    </div>
                    <div class="col-md-6 info-container-image"></div>
                </div>
            </div>
        </div>
    </div>
</div>