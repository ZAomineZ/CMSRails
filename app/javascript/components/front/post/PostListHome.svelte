<script>
    import PostRow from "./PostRow.svelte";
    // PROPS
    export let posts = []
</script>

<div class="block-view orange">
    <h2>Nouveaux coloriages ajoutés</h2>
    <div class="content">
        <div class="view-front orange">
            <div class="row">
                <div class="block-row">
                    {#each posts as post}
                        <PostRow post={post} />
                    {/each}
                </div>
            </div>
        </div>
    </div>
</div>