<script>
    import Header from './layout/Header.svelte'
    import Sidebar from './layout/Sidebar.svelte'
    import PostsTable from "./posts/PostsTable.svelte";
</script>

<Sidebar />
<Header/>
<div class="container_admin">
    <div class="container_body">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card bg-info text-white">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 info-container-text">
                                    <h5 class="card-title">Welcome back Admin !</h5>
                                    <p>Get familiar with dashboard, here are some ways to get started.</p>
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
            <div class="row">
                <div class="col-md-4">
                    <div class="card card-stat">
                        <div class="card-body">
                            <h5 class="card-title">New Posts</h5>
                            <h2 class="float-right">35</h2>
                            <p>From One Year</p>
                            <div class="progress" style="height: 10px">
                                <div class="progress-bar bg-warning" style="width: 50%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-stat">
                        <div class="card-body">
                            <h5 class="card-title">New Categories</h5>
                            <h2 class="float-right">10</h2>
                            <p>From One Year</p>
                            <div class="progress" style="height: 10px">
                                <div class="progress-bar bg-info" style="width: 75%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-stat">
                        <div class="card-body">
                            <h5 class="card-title">New Tags</h5>
                            <h2 class="float-right">25</h2>
                            <p>From One Year</p>
                            <div class="progress" style="height: 10px">
                                <div class="progress-bar bg-success" style="width: 10%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <PostsTable title="Last Posts"/>
                </div>
            </div>
        </div>
    </div>
</div>