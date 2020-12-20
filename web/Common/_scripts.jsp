<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Javascript files-->
<script src="Resource/vendor/jquery/jquery.min.js"></script>
<script src="Resource/vendor/popper.js/umd/popper.min.js"></script>
<script src="Resource/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="Resource/vendor/jquery.cookie/jquery.cookie.js"></script>
<script src="Resource/vendor/chart.js/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script src="Resource/js/charts-home.js"></script>
<script src="Resource/js/front.js"></script>

<!-- DataTable -->
<script src="https://cdn.rawgit.com/michalsnik/aos/2.1.1/dist/aos.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/dataTables.semanticui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
    $(document).ready(function () {
        $('#myTable').DataTable({
            "aaSorting": [[1, 'desc']],
            "scrollY": 300,
            "scrollX": true
        });
    });
</script>
