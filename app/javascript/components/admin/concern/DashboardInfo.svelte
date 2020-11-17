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
                            <li>Todo 1</li>
                            <li>Todo 2</li>
                            <li>Todo 3</li>
                        </ul>
                    </div>
                    <div class="col-md-6 info-container-image"></div>
                </div>
            </div>
        </div>
    </div>
</div>