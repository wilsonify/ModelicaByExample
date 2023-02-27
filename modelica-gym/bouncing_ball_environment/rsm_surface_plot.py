import plotly.graph_objects as go


def rsm_surface_plot(doe_results_df):
    fig = go.Figure(data=[go.Scatter3d(
        x=doe_results_df['time'].values,
        y=doe_results_df['h'].values,
        z=doe_results_df['e_rs'].values,
        mode='markers'
    )])
    fig.update_layout(scene=dict(
        xaxis_title='time',
        yaxis_title='h',
        zaxis_title='e_rs'
    ))
    return fig
