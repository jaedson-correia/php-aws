<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div style="display: flex; flex-direction: column;">
        <?php

            echo 'index';

            foreach (scandir('./') as $arquivo) {
                if (str_contains($arquivo, '.php')) {
                    echo '<a href="'.$arquivo.'">'.$arquivo.'</a>';
                }
            }

        ?>
    </div>
</body>
</html>
