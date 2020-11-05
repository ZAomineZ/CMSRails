<script>
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Libs
    import Tags from 'svelte-tags-input'
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
               title="Create Post"/>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Create Post</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <form action="/posts/create" method="POST">
                <div class="form-group">
                    <label for="title">Post Title</label>
                    <input class="form-control" id="title" name="title" placeholder="Enter your title..." type="text">
                </div>
                <div class="form-group">
                    <label for="slug">Post Title</label>
                    <input class="form-control" id="slug" name="slug" placeholder="Enter your title..." type="text">
                </div>
                <div class="form-group">
                    <label for="categories">Post Categories</label>
                    <Tags class="form-control" id="categories" name="categories" placeholder="Your categories..."/>
                </div>
                <div class="form-group">
                    <label for="content">Post Content</label>
                    <textarea class="form-control" cols="30" id="content" name="content" placeholder="Your content..."
                              rows="10"></textarea>
                </div>
                <button class="btn btn-primary" type="submit">Envoyer</button>
            </form>
        </div>
    </div>
</div>