<script>
    export let title = ''
    export let data_number = 0
    export let type = 'success'
</script>

<div class="card card-stat">
    <div class="card-body">
        <h5 class="card-title">New Posts</h5>
        <h2 class="float-right">{data_number}</h2>
        <p>From One Year</p>
        <div class="progress" style="height: 10px">
            <div class="progress-bar bg-{type}" style="width: 50%"></div>
        </div>
    </div>
</div>