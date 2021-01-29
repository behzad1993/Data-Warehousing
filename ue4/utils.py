import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

# Hilfsmethode


def display_semester(mean, median, mode, marks):
    #  Der nachfolgende Code gibt das Ergebnis aus
    print("Mean:", mean)
    print("Median:", median)
    print("Mode:", mode)

    plt.axvline(mean, color='k', linestyle='dashed', linewidth=3)
    plt.axvline(mode, color='orange', linestyle='dashed', linewidth=4)
    plt.axvline(median, color='b', linestyle='dashed', linewidth=5)

    min_ylim, max_ylim = plt.ylim()
    plt.text(mean, max_ylim*0.5,
             'Mean: {:.2f}'.format(mean),  fontsize=16, rotation=-90)
    plt.text(mode, max_ylim*0.5,
             'Mode: {:.2f}'.format(mode),  fontsize=16, rotation=-90)
    plt.text(median, max_ylim*0.5,
             'Median: {:.2f}'.format(median),  fontsize=16, rotation=-90)

    marks.hist(bins=len(marks.unique()))
    # and show it
    plt.show()


# Hilfsmethode zur Visualisierung
def plotEstimators(estimator, iris):
    # plot the correct assignment
    fig = plt.figure(figsize=(10, 5))
    fig.add_subplot(121)

    iris2 = sns.load_dataset("iris")

    # create one series per type of flower
    for name, group in iris2.groupby('species'):
        plt.scatter(group['petal_length'], group['petal_width'], label=name)
    plt.xlabel("Petal length")
    plt.ylabel("Petal width")
    plt.title("Ground Truth")

    # ***************************
    # KMeans
    # ***************************
    estimator_name = estimator.__class__.__name__ if estimator is not None else "Unknown"
    fig.add_subplot(122)

    # plot the clusters
    plt.title(estimator_name)
    plt.xlabel('Petal length')
    plt.ylabel('Petal width')

    if estimator is not None:
        plt.scatter(iris['petal_length'],
                    iris['petal_width'], c=estimator.labels_)

    plt.show()

    # Messe Genauigkeit als Anzahl über die falsch geclusterten Punkte
    if estimator is not None:
        r = iris2.join(pd.Series(estimator.labels_, name=estimator_name)
                       ).groupby(['species', estimator_name]).size()
        display(pd.DataFrame(r))
